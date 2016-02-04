References: <56B2D4A7.9080801@grom.net>
 <20160204070002.GC11143@hermes.click-hack.org>
From: Elmar Grom <elmar@grom.net>
Message-ID: <56B358E1.3020309@grom.net>
Date: Thu, 4 Feb 2016 05:57:53 -0800
MIME-Version: 1.0
In-Reply-To: <20160204070002.GC11143@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Trouble cross compiling Xenomai for Raspberry Pi
Reply-To: elmar@grom.net
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org


Oops. Sorry for that. I have been tinkering around with that stuff so 
much in the past few weeks that I am already seeing red spots all over...


On 2/3/2016 11:00 PM, Gilles Chanteperdrix wrote:
> On Wed, Feb 03, 2016 at 08:33:43PM -0800, Elmar Grom wrote:
>> make ARCH=arm ROSS_COMPILE=arm-linux-gnueabihf- O=build/linux bzImage
> Should be CROSS_COMPILE instead of ROSS_COMPILE.
>
>


