From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <CAFUnMkmjyjzjSZinsBGDFtDXbNU7GLbbLC7v=ztjk-MU-x2BVw@mail.gmail.com>
Date: Wed, 28 Jun 2017 11:53:01 -0400
In-Reply-To: <CAFUnMkmjyjzjSZinsBGDFtDXbNU7GLbbLC7v=ztjk-MU-x2BVw@mail.gmail.com>
 (Ashok kumar's message of "Wed, 28 Jun 2017 13:04:01 +0530")
Message-ID: <44tw30nm76.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] watchdog triggered -- signalling runaway thread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashok kumar <ashokkumar.bb@gmail.com>
Cc: xenomai@xenomai.org

Ashok kumar <ashokkumar.bb@gmail.com> writes:

> In xenomai I am running two task for 1ms task period for two task
> after a while  I get Cpu time limit exceeded (core dumped) in the terminal
> and in the syslog  the error message "watchdog triggered -- signalling
> runaway thread"
>
> is there any solution to this problem

Make sure your thread doesn't use all of the CPU.
It should block or sleep occasionally.

