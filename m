Message-ID: <50EC7D09.10302@zultron.com>
Date: Tue, 08 Jan 2013 14:09:45 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <50EB4DB3.4040207@xenomai.org>
	<201301081012.47861.leo@alaxarxa.net>
	<50EC7981.6050002@xenomai.org>
In-Reply-To: <50EC7981.6050002@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian squeeze packages preview for the
	amd64	architectures
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 01/08/2013 01:54 PM, Gilles Chanteperdrix wrote:
> On 01/08/2013 10:12 AM, Leopold Palomo-Avellaneda wrote:
>> Please Gilles, the linux image is produced using an standard stock version 
>> (just patched with xenomai)?
> 
> 
> Yes, this is vanilla linux 3.5.7 with the xenomai patch applied, and a
> kernel configuration derived from debian configuration for linux 3.2,
> enabling every new option (as a module if possible) in 3.5 compared to 3.2.

Hi Gilles,

I see that 3.5.7 is the most recent kernel in the 3.5 series.  Xenomai
2.6.2 (and also master, and adeos ipipe) ships patches labeled for
3.5.3, but you have presumably applied the 3.5.3 patches to the 3.5.7
kernel.

Is it acceptable practice to apply the Xenomai patches to later
sublevels in the same 3.x series like this, or is this best left to
experts like you?  When doing this, have you generally found the
resulting kernel to be reasonably stable?

	John

