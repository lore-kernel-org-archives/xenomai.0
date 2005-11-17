From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17276.48309.803651.529811@domain.hid>
Date: Thu, 17 Nov 2005 18:24:05 +0100
Subject: Re: [Xenomai-help] Blocking reads from pipes
In-Reply-To: <OF84150644.927CE822-ONC12570BC.00531CC2-C12570BC.00536AFA@datacon.at>
References: <437C8299.3010503@domain.hid>
	<OF84150644.927CE822-ONC12570BC.00531CC2-C12570BC.00536AFA@datacon.at>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
 > 
 > >
 > > >As a conclusion, the behaviour that you observed with Xenomai
 > > >pipes seems consistent with that of Linux' named pipes, except
 > > >that in Linux read() returns 0, and not an error code as you
 > > >observed with Xenomai.
 > > >
 > > >
 > > The read() call does *not* return when you close the *same* file handle
 > > from another pthread in the same process.
 > 
 > I confirm that and as I pointed it out in my previous mail - this is not
 > how it's supposed to be.
 > I'm currently on it. More news later.

I am not sure about that: Linux regular pipes follow the same behaviour
(the real destruction of the file descriptor is delayed until read()
really returns).

-- 


					    Gilles Chanteperdrix.

