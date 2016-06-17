References: <5763C908.6010007@gmail.com>
 <20160617100728.GK32532@hermes.click-hack.org>
From: Laurent LEQUIEVRE <laurent.lequievre@gmail.com>
Message-ID: <5763DEE9.1000801@gmail.com>
Date: Fri, 17 Jun 2016 13:28:41 +0200
MIME-Version: 1.0
In-Reply-To: <20160617100728.GK32532@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] need help to Xenomai Cobalt RTnet socket UDP recvfrom
 non blocking
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Laurent LEQUIEVRE <laurent.lequievre@univ-bpclermont.fr>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,

thank you for your quick answers !

where I can find this option : RTNET_RTIOC_TIMEOUT ?

cd /usr/xenomai_3_0_2/include
grep -r RTNET_RTIOC_TIMEOUT

--> Return nothing

Need to include something in my code ?

Thanks,

Laurent


Le 17/06/2016 12:07, Gilles Chanteperdrix a =E9crit :
> On Fri, Jun 17, 2016 at 11:55:20AM +0200, Laurent LEQUIEVRE wrote:
>> Hello,
>>
>> I installed xenomai 3.0.2 and try to test some RTnet features needed for
>> the communication with my Kuka robot arm.
>>
>> I specify that I want to work with the skin posix only.
>>
>> I need to create a UDP socket with a timeout on the 'recvfrom' function
>> (Non blocking recvfrom).
>>
>> I tested this first code :
>>
>> int udp_socket =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
>> bind(udp_socket, ...)
>> struct timeval timeout;
>> timeout.tv_sec =3D 1;
>> timeout.tv_usec =3D 0;
>>
>> setsockopt(udp_socket, SOL_SOCKET, SOCKET_SO_RCVTIMEO, &timeout,
>> sizeof(timeout));
>> --> this function return -1, errno=3D92, Protocol not available ???
> This socket option is not implemented in RTnet sockets. You can use
> the RTNET_RTIOC_TIMEOUT ioctl instead.
>
>
>> ....
>> recvfrom(udp_socket, ....) --> blocked ??
>>
>> I tested this second code :
>>
>> int udp_socket =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
>> bind(udp_socket, ...)
>> fcntl(udp_socket, F_SETFL, O_NONBLOCK);
>> --> this function return 0
>> ....
>> recvfrom(udp_socket, ....) --> blocked ??
> RTnet UDP recvfrom does not check the O_NONBLOCK flag, you can use
> recvmsg with MSG_DONTWAIT instead.
>


