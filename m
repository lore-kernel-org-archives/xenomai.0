Message-ID: <50A8BAB0.6040002@xenomai.org>
Date: Sun, 18 Nov 2012 11:38:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50A81190.5000200@rti.com>
In-Reply-To: <50A81190.5000200@rti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai support has been added to the OMG Data
 Distribution Service (DDS) Implementation from RTI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gerardo Pardo-Castellote <gerardo@rti.com>
Cc: xenomai@xenomai.org

On 11/17/2012 11:37 PM, Gerardo Pardo-Castellote wrote:

> 
> Hello,
> 
> I wanted to make everyone aware that RTI just added support for Xenomai 
> to RTI Connext DDS.  This is RTI's implementation of the OMG 
> Data-Distribution Service standard specification.
> 
> If deemed appropriate you could add this link to your Weblinks page:
> http://community.rti.com/content/forum-topic/howto-use-dds-xenomai-configure-xenomai-and-run-rti-connext-dds


Hi,

this is interesting, but not all the configuration advices apply to
latest kernels. I guess this is our fault, we should update the wiki.
Anyway:
- starting with the I-pipe for linux 3.2, disabling HPET timer or PC
speaker is no longer necessary
- starting with the I-pipe for linux 3.4, the processor choice with
regard to TSC does not really matter
- you can keep the "stack protector" option enabled on x86_32.

And something which has always been true: it is a bad idea to disable
ACPI completely, ACPI should be kept enabled, except for the
ACPI_PROCESSOR option.

-- 
                                                                Gilles.

