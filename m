From: Steve Hartmann <shartmann@cnt.canon.com>
Date: Tue, 7 Oct 2014 20:16:39 +0000
Message-ID: <D059B455.193D3%shartmann@cnt.canon.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] SIGXCPU on pthread_mutex_unlock()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi folks,

I'm having an issue I hope someone here might be able to shed some light on=
.

I am running Xenomai 2.6.4 on linux 3.4.6.  The application has a very larg=
e source base which was not originally designed for xenomai.   I am using x=
enomai because of some new requirements and the addition of EtherLabs Ether=
cat master.
So in one of the original threads, which is running at PRI 0,  I have two m=
utexes which when unlocked throw a SIGXCPU signal.  These mutexes are only =
locked/unlocked in this same thread.  I have seen this happen when a mutex =
which is not locked has an unlock attempt.  This is not the case for this i=
ssue.

What could I be doing which would cause a pthread_mutex_unlock to throw the=
 SIGXCPU signal?  Any suggestions for troubleshooting techniques?

