Message-ID: <1166378947.458587c3ef22e@domain.hid>
Date: Sun, 17 Dec 2006 19:09:07 +0100
From: barbalace@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] ppc Linux(root-domain) syscall
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


Reading Adeos patch (adeos-ipipe-2.6.14-ppc-1.3-05.patch) I see that afte=
r a
0xc00 (System call) is issued entry.S call __ipipe_syscall_root; this one=
 in
arch/ppc/kernel/ipipe-root.c dispatch the event and after this return
eventually DoSyscall is executed if __ipipe_syscall_root return 0.
If I don't missunderstand the code why not execute DoSyscall in the event
dispatching?

Thanks
Antonio

