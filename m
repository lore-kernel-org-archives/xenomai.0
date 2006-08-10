Message-ID: <46942.127.0.0.1.1155228223.squirrel@domain.hid>
Date: Thu, 10 Aug 2006 16:43:43 -0000 (UTC)
Subject: Re: [Xenomai-core] -EINTR using rt_pipe_read with TM_INFINITE
From: "Jacques GANGLOFF" <jacques@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
References: <58356.127.0.0.1.1155128979.squirrel@domain.hid>   
	<44DA6D99.9090502@domain.hid>
In-Reply-To: <44DA6D99.9090502@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

>
> That looks like a correct behaviour to me: the kernel module is trying
to read from pipe1 (MyPipe0, /dev/rtp0) and is blocked on it. The
user-space tool tries to do the same (is this intended BTW?). Then the
user-space program gets terminate, thus pipe1 is cleaned up. During that
cleanup all RT-readers on the pipe are woken up with -EINTR as return
code [1].
>

Hi Jan,

Thanks for your reply.

Indeed, I was on a wrong track: [CTRL-C] closed the application and also
the pipes, thus sending this INTR signal to the kernel module.

BTW, is there a limit to the size of a message one can send in a pipe.
Could this limit be around 65535 ?

I'm porting a RTAI application to xenomai and I am still hunting a bug on
a pipe. Writing on the user side more than 65530 bytes on a pipe yields a
"Cannot allocate memory" perror message.

Thanks a lot for your hints,
Jacques

 ___________________________________________

   Prof. Jacques GANGLOFF

   Strasbourg I University
   LSIIT Laboratory, EAVR team
   Bd S. Brant
   BP 10413, 67412 ILLKIRCH cedex, FRANCE
   Tel : +33 (0)3 90 24 44 68
   Fax : +33 (0)3 90 24 44 80
   http://eavr.u-strasbg.fr
____________________________________________





