(function() {
  var host = location.origin.replace(/^http/, 'ws');
  window.Minasan = Ember.Application.create({
    socketUrl: host+"/ws",
    ready: function() {
      return console.log("Ember namespace is ok");
    },
    ApplicationController: Ember.Controller.extend({
      socket: null
    }),
    ChatController: Ember.ArrayController.extend({
      content: [],
      handleMessage: function(m) {
        var obj;
        obj = Ember.Object.create({
          text: m.data
        });
        return this.pushObject(obj);
      }
    }),
    ApplicationView: Ember.View.extend({
      templateName: "application"
    }),
    LoginView: Ember.View.extend({
      templateName: "login"
    }),
    ChatView: Ember.View.extend({
      templateName: "chat"
    }),
    LoginFieldView: Ember.TextField.extend({
      insertNewline: function() {
        this.get("context.target").send("doLogin");
      }
    }),
    MessageFieldView: Ember.TextField.extend({
      insertNewline: function() {
        this.get("context.target").send("doSend");
      },
      didInsertElement: function() {
        this.$()[0].focus();
      }
    }),
    Router: Ember.Router.extend({
      enableLogging: true,
      root: Ember.Route.extend({
        index: Ember.Route.extend({
          route: "/",
          connectOutlets: function(router, context) {
            return router.get("applicationController").connectOutlet("login");
          },
          doLogin: function(router, context) {
            var login, socket;
            login = router.get("applicationController.login");
            socket = new WebSocket(Minasan.get("socketUrl"));
            return socket.onopen = function() {
              socket.send("login:" + login);
              router.set("applicationController.socket", socket);
              return router.transitionTo("chat", context);
            };
          }
        }),
        chat: Ember.Route.extend({
          route: "/chat",
          connectOutlets: function(router, context) {
            var socket;
            socket = router.get("applicationController.socket");
            if (socket) {
              router.get("applicationController").connectOutlet("chat");
              return socket.onmessage = function(message) {
                return router.get("chatController").handleMessage(message);
              };
            } else {
              return router.transitionTo("index", context);
            }
          },
          doSend: function(router, context) {
            var socket;
            socket = router.get("applicationController.socket");
            socket.send(router.get("chatController.newMessage"));
            return router.set("chatController.newMessage", "");
          }
        })
      })
    })
  });

  $(function() {
    console.log("Init app");
    return Minasan.initialize();
  });

}).call(this);
