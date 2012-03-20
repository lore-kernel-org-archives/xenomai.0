Message-ID: <4F6889DA.1070007@domain.hid>
Date: Tue, 20 Mar 2012 14:44:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CB8DFE21.1EE1B%glen@domain.hid>
In-Reply-To: <CB8DFE21.1EE1B%glen@domain.hid>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Linux Serial Does not work with
 CONFIG_XENO_OPT_PERVASIVE enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Glen Wernersbach <glen@domain.hid>
Cc: xenomai@xenomai.org

On 03/20/2012 02:28 PM, Glen Wernersbach wrote:
> Hi All,
>
> I install Xenomai 2.6.0 on AT91SAM9G20 system and have found that when
> CONFIG_XENO_OPT_PERVASIVE is enabled my standard non real time linux
> serial write then read serial program does not work.
>
> If I turn off CONFIG_XENO_OPT_PERVASIVE, my serial program does work.
>
> Any ideas why?????
>

A possible explanation would be that your application links with the=20
Xenomai POSIX lib (libpthread_rt), albeit it should not.

With pervasive support disabled, any routing from the overloaded POSIX=20
I/O calls to the Xenomai kernel would then fail.

If so, you should not link against the Xenomai libs if you need no -rt=20
service, or prevent symbol wrapping only for the POSIX I/O calls by=20
prefixing them by __real_* if you want Xenomai-enabled POSIX services=20
except the I/O support.

See http://xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai

>
> Also, when you turn CONFIG_XENO_OPT_PERVASIVE you get this error:
> CC kernel/xenomai/nucleus/synch.o
> kernel/xenomai/nucleus/synch.c: In function 'xnsynch_release_thread':
> kernel/xenomai/nucleus/synch.c:688:3: error: implicit declaration of
> function 'xnthread_get_rescnt'
> kernel/xenomai/nucleus/synch.c:689:4: error: implicit declaration of
> function 'xnshadow_send_sig'
>
> I had to go in and make the code for that option befor it always false.
>

http://git.xenomai.org/?p=3Dxenomai-2.6.git;a=3Dcommit;h=3D41b4f9c0f4bdf061=
07a788b762b5cf662b1d4108


> Glen
> --
> Glen Wernersbach
> President & CTO
>
> Jetsoft Development Co.
> 629 Old St Rt. 74 =96 Suite 210
> Cincinnati, Oh 45244
> Custom Programming Web Site: www.jetsoftdev.com
> Retail Products Web Site: www.scanhelp.com
> Phone: 513-528-6660
> Fax: 513-528-3470
> Cell 513-240-9929
> ----
> Partner for Software Technology
> Jacobs Automation
> 2365 Progress Drive
> Hebron, KY 41048
> (513) 297-7550
> ----
> "Support Dyslexia Research"
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.

