Message-ID: <44A4F1E9.3030202@domain.hid>
Date: Fri, 30 Jun 2006 11:42:01 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] prepare_kernel --output-patch
References: <44A4D271.90006@domain.hid>
	<200606301826.06445.rlenglet@domain.hid>
In-Reply-To: <200606301826.06445.rlenglet@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org

Romain Lenglet wrote:
> Wolfgang Grandegger wrote:
>> what is "prepare_kernel --output-patch" useful for?
> 
> It modifies the behavior of prepare_kernel, so that it does not 
> modify the kernel source tree (except that it must apply the 
> Adeos patch), but instead generates a patch file that has the 
> same effect when applied against that Adeos-patched kernel 
> source tree.
> 
> Therefore, it is useful for creating Xenomai packages for 
> GNU/Linux distributions, such as packages based on dh-kpatches 
> in Debian, which require to have patch files.

Ah, OK. I understood what it does but I did not realize what its useful for.

Thanks.

Wolfgang.

