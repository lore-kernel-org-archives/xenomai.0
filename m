From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Tue, 27 Jun 2017 14:30:10 +0000
Message-ID: <DB6PR0701MB24563F8662BECB25FEA8937DB5DC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <CAFUnMkmx6TK94a4Q0qtmaaGRnvW_cHpR4NaBcT-+ef8GaY_4aw@mail.gmail.com>
In-Reply-To: <CAFUnMkmx6TK94a4Q0qtmaaGRnvW_cHpR4NaBcT-+ef8GaY_4aw@mail.gmail.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] CPU time limit exceeded (core dumped)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashok kumar <ashokkumar.bb@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Your task is sent a SIGXCPU/SIGDEBUG signal when it does not sleep for more=
 than a given amount of time (I think default is 4 seconds).
Make sure your task sleeps (e.g.: rt_task_suspend(), rt_task_sleep() or wai=
t on an interrupt) as soon as it is done processing.

Alternatively, you may have T_WARNSW set for your task, which would cause a=
 signal to be sent to the task when it switches to secondary mode (e.g.: ht=
tps://xenomai.org/documentation/trunk/html/api/sigxcpu_8c-example.html )

From: Xenomai <xenomai-bounces@xenomai.org> on behalf of Ashok kumar <ashok=
kumar.bb@gmail.com>
Sent: 27 June 2017 15:23
To: xenomai@xenomai.org
Subject: [Xenomai] CPU time limit exceeded (core dumped)

Hi,
I am using xenomai -2.6.2.1 . I have configured two task, after some time
of running
I got this message in the terminal
CPU time limit exceeded (core dumped)

in one task for 1ms time I am reading Ethercat frames and other task of 1ms
I am running an application for calculation.

please provide me the solution for this  error

CPU time limit exceeded (core dumped)

Thank you
Ashok
_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

