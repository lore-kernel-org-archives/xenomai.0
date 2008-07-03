Message-ID: <486CE4C5.8050309@domain.hid>
Date: Thu, 03 Jul 2008 10:40:05 -0400
From: Michael Galea <michaelgalea@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] How can I make Xenomai share a mii bus with the
	kernel?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I wonder if someone can suggest an approach to the following problem.

We need to use xenomai to manage devices on the mii bus.  The mii bus 
has PHYs managed by linux. What is the best way of providing access to 
both linux and xenomai?

I know that before xenomai "loads", I can simply access the mii bus from 
linux.  But after xenomai loads, is the right answer to make the linux 
function that reads the phy migrate into the xenomai domain and contend 
for the bus there?

