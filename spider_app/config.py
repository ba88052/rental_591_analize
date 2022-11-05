class Config(object):
    TESTING = False
    DEBUG = False

class DevelopmentConfig(Config):
    ENV = "developmaent"
    DEBUG = True

class TestingConfig(Config):
    ENV = "testing"
    Testing = True