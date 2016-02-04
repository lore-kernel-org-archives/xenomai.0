Date: Thu, 4 Feb 2016 08:00:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160204070002.GC11143@hermes.click-hack.org>
References: <56B2D4A7.9080801@grom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56B2D4A7.9080801@grom.net>
Subject: Re: [Xenomai] Trouble cross compiling Xenomai for Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Elmar Grom <elmar@grom.net>
Cc: xenomai@xenomai.org

On Wed, Feb 03, 2016 at 08:33:43PM -0800, Elmar Grom wrote:
> make ARCH=arm ROSS_COMPILE=arm-linux-gnueabihf- O=build/linux bzImage 

Should be CROSS_COMPILE instead of ROSS_COMPILE.


-- 
					    Gilles.
https://click-hack.org

