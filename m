From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17535.18007.179715.207040@domain.hid>
Date: Thu, 1 Jun 2006 21:56:07 +0200
Subject: Re: [Xenomai-help] xnpod help
In-Reply-To: <39142.155.98.4.39.1149186052.squirrel@domain.hid>
References: <39142.155.98.4.39.1149186052.squirrel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

Brandt Erickson wrote:
 > Hey,
 > I'm trying to write a simple looping module to test out xenomai nucleus
 > usage.  The problem is, when I insert the module (code attached), only the
 > printks from the initialization function ever get displayed and none from
 > the indefinite loop.  All the pod startup functions return success, so is
 > the thread working and just not successfully sending the messages out or
 > is the thread not starting up at all?  Could someone tell me if I'm using
 > the xenomai nucleus correctly?  Thanks.
 > -Brandt

If you seriously intend to write a skin, you should have a look at the
simulator, it will allow you to run your skin in a debugger and to get
reproducible behaviours.

-- 


					    Gilles Chanteperdrix.

