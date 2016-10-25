from abc import ABCMeta 

#Abstract Factory
class StandardFactory(object):
    
    @staticmethod
    def get_factory(factory):
        if factory == 'soccer':
            return SoccerFactory()
        elif factory == 'volley':
            return VolleyFactory()
        raise TypeError('Unknown Factory.')


#Factory
class SoccerFactory(object):
    def get_ball(self):
        return BallSoccer();


class VolleyFactory(object):
    def get_ball(self):
        return BallVolley();
    
    
# Product Interface
class Ball(object):
    __metaclass__ = ABCMeta
    def play(self):
        pass
        
        
# Products
class BallSoccer(object):
    def play(self):
        return 'Bola esta rolando...'


class BallVolley(object):
    def play(self):
        return 'Bola esta voando!'
    
    
if __name__ =="__main__":
    factory = StandardFactory.get_factory('volley')
    ball = factory.get_ball()
    print ball.play()
   
    factory = StandardFactory.get_factory('soccer')
    ball = factory.get_ball()
    print ball.play() 