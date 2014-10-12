Date: Sun, 12 Oct 2014 06:56:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141012045616.GA13181@sisyphus.hd.free.fr>
References: <CABVE6k1pNP4bPc4VTtUuT7Po4Qxfaj7DqEzfgNdLMto=AbKVtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVE6k1pNP4bPc4VTtUuT7Po4Qxfaj7DqEzfgNdLMto=AbKVtQ@mail.gmail.com>
Subject: Re: [Xenomai] configuration kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hasret =?utf-8?Q?Sar=C4=B1yer?= <hsrtsryr@gmail.com>
Cc: Xenomai <Xenomai@xenomai.org>

On Sun, Oct 12, 2014 at 04:30:59AM +0300, Hasret Sarıyer wrote:
> "You should *not* disable power management globally, the only configuration
> options which should be disabled in this area are:
> 
>    - CONFIG_APM
>    - CONFIG_ACPI_PROCESSOR
> 
> " is said In "
> http://xenomai.org/2014/06/configuring-for-x86-based-dual-kernels/#BEWARE_of_internet_archives"
> guide. I disabled ACPI. I don't know where APM is.

It seems CONFIG_APM disappeared from kernel configuration. Also,
once again, you do not read the documentation correctly. It
says to disable CONFIG_ACPI_PROCESSOR, and explicitly to NOT disable
CONFIG_ACPI.

-- 
					    Gilles.

