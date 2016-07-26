build:
	docker build -t resteasyexample -f Dockerfile .

start:
	docker run -d -p 8080:8080 --name resteasy resteasyexample

clean:
	docker rm -f $$(docker ps -qa) || true
	docker rmi -f $$(docker images -qa) || true
