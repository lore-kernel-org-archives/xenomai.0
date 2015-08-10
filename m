MIME-Version: 1.0
Sender: jpromerob@unal.edu.co
Date: Mon, 10 Aug 2015 18:44:11 +0200
Message-ID: <CANccXANz3q6=rOMO=Cbn6D1PNV2Hx4Lfy9dBw3iALYQ-cAxXuA@mail.gmail.com>
From: Juan Pablo Romero Bermudez <jpromerob@hotmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] rt_dev_bind returns -ENOTTY (UDP and TCP Client-Server
 communication using RTnet)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I'm new to RTnet and I'm having trouble establishing UDP and TCP
client-server communication using RTnet:

I'm getting -ENOTTY (-25) when calling rt_dev_bind ...

Does anybody know how solve this problem?

The body of my UDP server task:

int sockfd,n;
struct sockaddr_in servaddr,cliaddr;
socklen_t len;
char mesg[2];
memset(&servaddr, 0, sizeof(struct sockaddr_in));

sockfd=rt_dev_socket(AF_INET,SOCK_DGRAM,0);
servaddr.sin_family = AF_INET;
servaddr.sin_addr.s_addr=htonl(INADDR_ANY);
servaddr.sin_port=htons(32000);

n = rt_dev_bind(sockfd,(struct sockaddr *)&servaddr,sizeof(servaddr));

while (1)
{
len = sizeof(cliaddr);
n = rt_dev_recv(sockfd,mesg,2,0);
n = rt_dev_send(sockfd,mesg,n,0);
usleep(250000);
}


The body of my UDP client task:

int sockfd,n, i;
struct sockaddr_in servaddr,cliaddr;
char sendline[2];
char recvline[2];
memset(&servaddr, 0, sizeof(struct sockaddr_in));

sockfd=rt_dev_socket(AF_INET,SOCK_DGRAM,0);
servaddr.sin_family = AF_INET;
servaddr.sin_addr.s_addr=inet_addr("192.168.218.18");
servaddr.sin_port=htons(32000);
i = 0;
while (1)
{
i++;
sendline[0]=0x30+i%10;
sendline[1]='\0';
n = rt_dev_send(sockfd,sendline,strlen(sendline),0);
n = rt_dev_recv(sockfd,recvline,2,0);
recvline[n]=0;
sleep(1);
}

Thanks in advance

Regards

Juan
