Message-ID: <518E84CD.7010506@xenomai.org>
Date: Sat, 11 May 2013 19:50:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] posix signals rework
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Hi,

following the discussions on the I-pipe patch, here is a proposed
modification for the posix thread signals relying on
xnshadow_call_mayday. xnshadow_call_mayday is modified to not send a
signal, expecting its caller to have sent one, then a pending signal to
a user-space posix skin thread causes xnshadow_call_mayday to be called.

Whereas it works, what still seems strange with this implementation is
to have to set the XNAMOK bit to cause xnshadow_sys_mayday to switch to
secondary mode.

Thanks in advance for your review.
Regards.

-- 
                                                                Gilles.

