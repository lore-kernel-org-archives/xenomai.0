References: <CAKJ14Ndf43hdOcFSVP_S-ZLji=smtpj7bih=s8618Yfsh5OG7g@mail.gmail.com>
From: Christophe Carton <christophe.carton@ixblue.com>
Message-ID: <0a153821-210d-0add-e986-3f424b7cf4ed@ixblue.com>
Date: Thu, 10 Aug 2017 16:19:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAKJ14Ndf43hdOcFSVP_S-ZLji=smtpj7bih=s8618Yfsh5OG7g@mail.gmail.com>
Content-Language: fr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] UDP comms via Xenomai 3.0.5 + RTnet ? (Paul Wilkinson)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Le 10/08/2017 =C3=A0 15:36, Andreas Glatz a =C3=A9crit :
>> # ./rtping 10.0.0.1
>> Real-time PING 10.0.0.1 56(84) bytes of data.
>> ioctl: No route to host
> You should populate your RTnet routing table with some meaningful
> combinations of IP address and MAC address after bringing it up.
>
> The other non-persistent option is to ping your RTnet device from a
> non-RTnet device, which auto populates the RTnet routing table with
> the IP & mac pair of the sender. After that you can rtping the other
> device as well.
>
>> However, if I use 'rtnet start', rtping succeeds :-
>>
>> # ./rtping 10.0.0.1
>> Real-time PING 10.0.0.1 56(84) bytes of data.
>> 64 bytes from 127.0.0.1: icmp_seq=3D1 time=3D4.8 us
>> 64 bytes from 127.0.0.1: icmp_seq=3D2 time=3D4.4 us
>> 64 bytes from 127.0.0.1: icmp_seq=3D3 time=3D3.4 us
>> 64 bytes from 127.0.0.1: icmp_seq=3D4 time=3D3.7 us
>> 64 bytes from 127.0.0.1: icmp_seq=3D5 time=3D4.2 us
> Somehow your rtnet start script does not populate the routing table
> properly. Hence if you ping 10.0.0.1, you actually get a reply from
> localhost (127.0.0.1).
>
>> # ./rtroute
>> Host Routing Table
>> Hash?? ?Destination?? ?HW Address?? ??? ?Device
>> 00?? ?0.0.0.0 ??? ?00:00:00:00:00:00?? ?rtlo
>> 01?? ?127.0.0.1 ??? ?00:00:00:00:00:00?? ?rtlo
>> 02?? ?10.0.0.2 ??? ?00:00:00:00:00:00?? ?rtlo
>> 3F?? ?10.255.255.255?? ?FF:FF:FF:FF:FF:FF?? ?rteth0
>>
> See:
> rtroute --help
>
> E.g (assuming that 02:00:00:00:01:02 is the MAC of 10.0.0.1):
>
> rtroute add 10.0.0.1 02:00:00:00:01:02 dev rteth0
>
> ... after that rtping should work.
If you do not know the MAC of 10.0.0.1 you may also execute:

rtroute solicit 10.0.0.1 dev rteht0 #See: rtroute --help

This will force an ARP exchange.

>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

--=20

*Christophe*

