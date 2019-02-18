From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: Disable watchdog
Date: Mon, 18 Feb 2019 11:23:19 +0000
Message-ID: <AM0PR07MB5572185C22361C2A197A5324B5630@AM0PR07MB5572.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi there,
I have my kernel (4.4.113-ti-xenomai-r149 on BeagleBone BlacK) compiled wit=
h=20
CONFIG_XENO_OPT_WATCHDOG=3Dy
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=3D4

I would like to experience the breeze of running without watchdog, to see w=
hat the bare-metal performance of the board are, removing the overhead of c=
ontext switching and thread scheduling. I know this could be harmful for Li=
nux, but I'd like to see what happens there. Is there any way I could disab=
le the watchdog and have a thread busy waiting on a hardware flag, without =
recompiling the kernel with CONFIG_XENO_OPT_WATCHDOG=3D0 ?

I have tried  catching SIGXCPU, and also using pthread_sigmask, e.g.:
        sigset_t set;
        int s;
        sigemptyset(&set);
        sigaddset(&set, SIGXCPU);
        s =3D pthread_sigmask(SIG_BLOCK, &set, NULL);

but in both cases my thread is temporarily preempted when the watchdog trig=
gers.

Thanks,
Giulio=

