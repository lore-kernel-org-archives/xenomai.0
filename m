From: Alex Plits <alex_plits@radwin.com>
Date: Wed, 11 May 2016 06:58:52 +0000
Message-ID: <DB5PR06MB1287D4090873A5C9EC9B540A8F720@DB5PR06MB1287.eurprd06.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] XDDP NRT to RT communication and select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

We require communication between non-real time and real time thread in xeno=
mai 3.x, so naturally we planned to use
XDDP.
After careful read and looking into examples in smokey we tried to implemen=
t simple communication
Between NRT thread that sends via RTP pseudo device a buffer to RT thread w=
hich is blocked on xenomai "select" (read_fds)
based on a ripped example of XDDP in smokey (without 2nd real time thread),
i.e. NRT thread periodically sends messages to the RT thread waiting on sel=
ect before actual receive call.
Unfortunately the "select" call on the RT thread was never triggered - alth=
ough in the smokey unit test it worked as expected,
the only difference was the 2nd real time thread (which we got rid of in ou=
r case) used "sendto" call to that XDDP socket.
After some xenomai code examination we saw that XDDP send/recv functions do=
 signal xenomai select waiters which explains the smokey case (sendto trigg=
ered select) but
It seems (correct me if I'm wrong) that xnpipe_write/read do not.
In order to confirm that we used "xnselect_signal" to trigger the xenomai s=
elect waiters in the "__xddp_input_handler" callback that is called inside =
xnpipe_write and this seemed to work.
So my queries are -

1.       Does XDDP mechanism support select call for NRT writers  - or did =
we misread https://xenomai.org/2014/08/porting-a-linux-application-to-xenom=
ai-dual-kernel/#IO_multiplexing_with_select?

2.       Will the opposite direction work i.e. RT-> NRT that is waiting on =
a select?

3.       Is the small patch we added acceptable for the case described abov=
e / is there any additional locking that we need to handle?

Thanks in advance,
Alex Plits
