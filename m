Message-ID: <b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
In-Reply-To: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
References: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
Date: Tue, 18 Jun 2013 18:01:30 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] CPU time limit exceeded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: HAUTBOIS Flavian <Flavian.HAUTBOIS@cea.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


HAUTBOIS Flavian wrote:
> Hello,
>
> I'm having a 'CPU time limit exceeded' error. Of course I tried to set
> ulimit to unlimted, without any success.
>
> According to the soem developpers, everything works fine on Xenomai 2.5.6,
> but I have to use Xenomai 2.6.2. Do you have any idea what could trigger
> this error and how to fix it?

Hi,

You should first make sure that you do not get the SIGXCPU signal because
you enabled the PTHREAD_WARNSW bit (see pthread_set_mode_np documentation)
and __wrap_send falls back to Linux "send" service. Which would mean, that
you are not, in fact, using RTNet to send the network packet which causes
this signal to be sent. See examples/native/sigdebug.c for an example of
SIGXCPU handler which prints the reason for receiving this signal.

Regards.

-- 
                    Gilles.


