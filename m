Message-ID: <5051E332.8090505@xenomai.org>
Date: Thu, 13 Sep 2012 15:44:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <f4e484caea0dc89aaa132406e82ac5ae@theropers.us>
	<70283B31-48C9-4753-A073-993507CF0A96@kabelmail.de>
In-Reply-To: <70283B31-48C9-4753-A073-993507CF0A96@kabelmail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: adam.r.roper@gmail.com, xenomai@xenomai.org

On 09/13/2012 03:31 PM, Stephan Kappertz wrote:
>> Hi Stephan,
>> 
>> 
>> I saw that you got Xenomai running on the Beaglebone from the
>> thread here:
>> http://www.xenomai.org/pipermail/xenomai/2012-July/000476.html
>> 
>> 
>> I was wondering if you would be willing to share the source code
>> for this.  I am interested in getting Xenomai working on the
>> Beaglebone but I have no previous experience with Xenomai.  I would
>> greatly appreciate it if you would be willing to share your source
>> code.
>> 
>> 
>> Thanks!
>> 
>> 
>> Adam Roper
>> 
>> 
> 
> I can provide a combined patchfile against the vanilla 3.2.21 kernel
> that includes both the AM335x support as provided by Koen Kois git
> repository and the xenomai/adeos patch. That patch file is 9.1 MB. Do
> you have an FTP server where I can upload it to?

We could distribute this work with Xenomai sources, if you were willing
to provide it in a more manageable way, such as a pre-patch to apply to
the Koen Kois git repository before the I-pipe patch, then a post-patch.
Like we do for imx5x/imx6q.

Regards.

-- 
					    Gilles.

