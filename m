MIME-Version: 1.0
Message-ID: <trinity-718930e5-2f32-4c34-98da-532709fb9429-1423747391055@3capp-webde-bs58>
From: JK.Behnke@web.de
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2015 14:23:11 +0100
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] application start is slower with xenomai 2.6.4 than 2.4.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I noticed that running the same xenomai application against xenomai 2.6.4
is significantly slower on start up, than it was with xenomai 2.4.10.
Calling my xenomai application 100 times by a bash script takes about=20
1 sec on xenomai 2.4.10. On xenomai 2.6.4 however it takes about 20 secs.
Even if I strip down my application to the absolut minimum of xenomai=20
calls like this

main()
{
=C2=A0 mlockall(...);
=C2=A0 rt_task_shadow(...);
}

I get the same behaviour.

I have tested this on the same hardware (x86, atom). The only difference=
=20
is the Linux kernel (2.6.30.8 vs 3.14.17) version and the xenomai version
(2.4.10 vs 2.6.4).

I once mistakenly linked my xenomai 2.4.10 application against libxenomai
and also got the same behaviour (slower startup).
So I suspect this has something to do with libxenomai I need to link=20
against, when building xenomai applications using xenomai 2.6.4.

Is there a kind of additional setup behind the scenes in xenomai 2.6.4?
Is there a way to speed up the application start?
Any hint is appreciated.

Regards
Jochen

