References: <1396873278.9042.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <53429F30.4080204@xenomai.org>
 <1396961235.36322.YahooMailNeo@web163901.mail.gq1.yahoo.com>
 <5343F1D2.8080909@xenomai.org>
 <1396965543.83663.YahooMailNeo@web163905.mail.gq1.yahoo.com>
 <53440F37.1090605@xenomai.org>
Message-ID: <1396974881.77842.YahooMailNeo@web163902.mail.gq1.yahoo.com>
Date: Tue, 8 Apr 2014 09:34:41 -0700 (PDT)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <53440F37.1090605@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai] patch for 3.14 kernel ?
Reply-To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tuesday, April 8, 2014 5:01 PM, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
 
On 04/08/2014 03:59 PM, Huub Van Niekerk wrote:
> On Tuesday, April 8, 2014 2:55 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>
> On 04/08/2014 02:47 PM, Huub Van Niekerk wrote:
>> Right now I can't test anything under the 3.10.18 kernel since for
>> some weird reason (which has nothing to do with Xenomai) my network
>> and USB (combined on my board) is off. With the same configuration
>> file, the 3.14 kernel works fine.
>>
>
>> In 3.10 kernel, a new configuration disabled by default is the USB
>> PHY. You need to select the USB PHY corresponding to your board. If
>> you want to boot using NFS, you have to enable the PHY as built-in
>> in addition to the built-in network controller. I did that for the
>> pandaboard (which uses the same network adapter as Beagle-XM I
>> believe), and it boots just fine using NFS.
>
> I had the 3.10.18 kernel working (with xenomai), including the
> smsc95xx, usb phy, usb hid, etc. Just the clock didnt work. For some
> reason now all of USB and networking is off. I already triple-checked
> all options, and so far no solution.

>If everything runs as module, have you installed the module and run 
>depmod -a ?

What I can put as built-in, I do. So that's what I did for all of them.
