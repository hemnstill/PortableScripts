import sys
import foo

if __name__ == "__main__":
    print(foo.hello(sys.argv[1:]))

    sys.exit(42)
