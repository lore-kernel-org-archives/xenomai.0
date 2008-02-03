MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18342.6175.696597.309657@domain.hid>
Date: Sun, 3 Feb 2008 20:38:07 +0100
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3768B0@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768B0@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] FW:  periodic task question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
 > 
 > 
 > > -----Original Message-----
 > > From: Steven Seeger
 > > Sent: Sunday, February 03, 2008 12:01 PM
 > > To: 'Gilles Chanteperdrix'
 > > Subject: RE: [Xenomai-help] periodic task question
 > > 
 > > I guess I don't see the difference here. I lock the mutex first, and
 > then
 > > wait on the conditional. The only time that conditional is ever
 > signaled
 > > is after something else sets playing to non-zero. (This code actually
 > > clears playing after locking that mutex, however I didn't put that in
 > > here.)

It was a general advice, not a proposed fix for the bug you observe.
By locking the mutex when reading or writing the "playing" variable, you
ensure that nobody else will be changing the "playing" variable while you
look at it and hence you will not miss any wake up. By running
rt_cond_wait in a while loop, you cause your thread to go to sleep in
case of spurious wake up.


-- 


					    Gilles Chanteperdrix.

