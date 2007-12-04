MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18261.58019.287350.591595@domain.hid>
Date: Wed, 5 Dec 2007 00:28:35 +0100
In-Reply-To: <8b3b30860712041501v55e485e0t1ec4aca98d31b92f@domain.hid>
References: <8b3b30860712041501v55e485e0t1ec4aca98d31b92f@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] rtp[0-9]*
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Racconico Lambrati <racconico.lambrati@domain.hid>
Cc: xenomai@xenomai.org

Racconico Lambrati wrote:
 > Hi.
 >        I have developed a Library to handle inter process communication
 > using the /dev/rtp[0-9]* device.
 > 
 > Now I'm porting all on an embedded distro, that haven't this device.
 > 
 > My question (very newbie at all) is how to create this special, considering
 > that I have no compiler on this distro (it's a very small distribution)

Usually, utilities used to create filesystem images for embedded distros
have a way to pass the list of devices nodes in /dev. /dev/rtp[0-9]*
devices are character devices with major number 150 and the same minor
number as their name.

To create these devices manually, run:
for((i=0; i<32; i++)); do mknod /dev/rtp$i c 150 $i; done

-- 


					    Gilles Chanteperdrix.

