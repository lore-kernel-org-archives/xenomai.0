From: "Giorgio Buffa" <giorgiobuffa.work@gmail.com>
References: <00e901d0b413$83853d70$8a8fb850$@gmail.com>
 <20150701154521.GC13256@hermes.click-hack.org>
In-Reply-To: <20150701154521.GC13256@hermes.click-hack.org>
Date: Mon, 13 Jul 2015 10:40:41 +0200
Message-ID: <000c01d0bd47$9a8612f0$cf9238d0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: it
Subject: [Xenomai] R: Have you ever used the Linux Test Project (LTP)
	realtime testsuite with Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> LTP is regularly used with Xenomai, but as part of the dohell script,
> generating Linux load.
> 
> What you want to do, I guess, is to recompile the rt-tests for the Xenomai
> POSIX API. In that case, you should not underestimate what this task
means,
> it means more than just recompiling with the xeno-config flags, see:
> https://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-
> kernel/

Hi Gilles!
Thank you for the pointer to the porting guide, it is very useful!

Yes, you're right: using the rt-tests requires more work than just a
re-compilation with 'xeno-config' flags. BTW some of these tests are
interesting, I think I will investigate on that matter a little more.

Thank you again and king regards,
Giorgio Buffa.


