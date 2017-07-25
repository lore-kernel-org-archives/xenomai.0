Date: Tue, 25 Jul 2017 19:02:14 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170725190214.6f2fd892@md1em3qc>
In-Reply-To: <DEB5F512-B818-454D-A423-7CB391071BBD@gmail.com>
References: <DEB5F512-B818-454D-A423-7CB391071BBD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_create fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mathew.benson@gmail.com
Cc: xenomai@xenomai.org

Am Tue, 25 Jul 2017 07:48:46 -0500
schrieb <mathew.benson@gmail.com>:

> I ported Xenomai 3.0.5 to Petalinux 2017.1.  The supported tests run
> fine, but my code is failing.  rt_task_create always fails with errno
> set to 17 (EEXIST).  Doesn't matter what arguments I give it.  Before
> I dissect this further, does anybody have any insight?

Your thread might not have a shadow yet and you might see a case where
an EPERM is transformed into an EEXIST.
We did not discuss the transformation bug yet. But your solution might
be to just shadow on EPERM and EEXIST, or before calling anything that
needs a shadow.

http://www.xenomai.org/pipermail/xenomai/2017-July/037474.html

Henning

> Sent from my iPhone
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


