FROM alpine:3.8

RUN apk --update add sudo bash python py-pip openssl ca-certificates python-dev libffi-dev openssl-dev build-base

RUN pip install --upgrade pip cffi && pip install ansible

RUN apk add --update python-dev py-pip py-setuptools ca-certificates gcc libffi-dev openssl-dev musl-dev linux-headers curl rsync python3 netcat-openbsd
RUN apk add gnupg openssh-client git


ENV JAVA_HOME=/usr/lib/jvm/default-jvm/jre

ARG KUBESPRAY_VERSION
RUN apk add curl
RUN curl -Ls https://raw.githubusercontent.com/kubernetes-sigs/kubespray/${KUBESPRAY_VERSION}/requirements.txt > /tmp/kubespray-requirements.txt
RUN pip install -r /tmp/kubespray-requirements.txt

ADD ansible.cfg /etc/ansible/ansible.cfg

# Kubernetes CLI
ARG KUBECTL_VERSION
ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

ARG HELM_VERSION
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -o /tmp/helm.tar.gz && \
    mkdir -p /tmp/helm && \
    tar -xvvf /tmp/helm.tar.gz -C /tmp/helm && \
    mv /tmp/helm/linux-amd64/helm /tmp/helm/linux-amd64/tiller /usr/local/bin

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]