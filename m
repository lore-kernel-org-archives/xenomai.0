Message-ID: <516C78FD.1090002@web.de>
Date: Tue, 16 Apr 2013 00:02:37 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <E1U2RE9-0007Zc-Em@xenomai.org> <516983AF.2000909@xenomai.org>
In-Reply-To: <516983AF.2000909@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : switchtest: Add SSE and
	AVX check
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

On 2013-04-13 18:11, Gilles Chanteperdrix wrote:
> On 02/04/2013 07:57 PM, GIT version control wrote:
> =

>> Module: xenomai-2.6
>> Branch: master
>> Commit: 192597326a0becd1980cb6c5cc9395af18a19c60
>> URL:    http://git.xenomai.org/?p=3Dxenomai-2.6.git;a=3Dcommit;h=3D19259=
7326a0becd1980cb6c5cc9395af18a19c60
>>
>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>> Date:   Tue Jan 29 18:46:13 2013 +0100
>>
>> switchtest: Add SSE and AVX check
>>
>> Add a test for switching the lower SSE registers xmm0..7 or AVX
>> registers ymm0..7, provided the CPU supports the corresponding
>> feature. As xmm and ymm share their storage, we only need to check
>> one of the features.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> ---
> =

> =

>>  static inline unsigned fp_regs_check(unsigned val)
>>  {
>>  	unsigned i, result =3D val;
>> +	uint64_t vec[8][4];
>>  	unsigned e[8];
>>  =

>>  	for (i =3D 0; i < 8; i++)
>>  		__asm__ __volatile__("fistpl %0":"=3Dm"(e[7 - i]));
>> +	if (fp_features & FP_FEATURE_AVX) {
>> +		__asm__ __volatile__(
>> +			"vmovupd %%ymm0,%0;"
>> +			"vmovupd %%ymm1,%1;"
>> +			"vmovupd %%ymm2,%2;"
>> +			"vmovupd %%ymm3,%3;"
>> +			"vmovupd %%ymm4,%4;"
>> +			"vmovupd %%ymm5,%5;"
>> +			"vmovupd %%ymm6,%6;"
>> +			"vmovupd %%ymm7,%7;"
>> +			:
>> +			: "m" (vec[0][0]), "m" (vec[1][0]),
>> +			  "m" (vec[2][0]), "m" (vec[3][0]),
>> +			  "m" (vec[4][0]), "m" (vec[5][0]),
>> +			  "m" (vec[6][0]), "m" (vec[7][0]));
>> +	} else if (fp_features & FP_FEATURE_SSE) {
>> +		__asm__ __volatile__(
>> +			"movupd %%xmm0,%0;"
>> +			"movupd %%xmm1,%1;"
>> +			"movupd %%xmm2,%2;"
>> +			"movupd %%xmm3,%3;"
>> +			"movupd %%xmm4,%4;"
>> +			"movupd %%xmm5,%5;"
>> +			"movupd %%xmm6,%6;"
>> +			"movupd %%xmm7,%7;"
>> +			:
>> +			: "m" (vec[0][0]), "m" (vec[1][0]),
>> +			  "m" (vec[2][0]), "m" (vec[3][0]),
>> +			  "m" (vec[4][0]), "m" (vec[5][0]),
>> +			  "m" (vec[6][0]), "m" (vec[7][0]));
>> +	}
>>  =

>>  	for (i =3D 0; i < 8; i++)
>>  		if (e[i] !=3D val) {
>> @@ -65,8 +148,33 @@ static inline unsigned fp_regs_check(unsigned val)
>>  			result =3D e[i];
>>  		}
>>  =

>> +	if (fp_features & FP_FEATURE_AVX) {
>> +		for (i =3D 0; i < 8; i++) {
>> +			int error =3D 0;
>> +			if (vec[i][0] !=3D val) {
>> +				result =3D vec[i][0];
>> +				error =3D 1;
>> +			}
>> +			if (vec[i][2] !=3D val) {
>> +				result =3D vec[i][2];
>> +				error =3D 1;
>> +			}
>> +			if (error)
>> +				printk("ymm%d: %llu/%llu !=3D %u/%u\n",
>> +				       i, (unsigned long long)vec[i][0],
>> +				       (unsigned long long)vec[i][2],
>> +				       val, val);
>> +		}
>> +	} else if (fp_features & FP_FEATURE_SSE) {
>> +		for (i =3D 0; i < 8; i++)
>> +			if (vec[i][0] !=3D val) {
>> +				printk("xmm%d: %llu !=3D %u\n",
>> +				       i, (unsigned long long)vec[i][0], val);
>> +				result =3D vec[i][0];
>> +			}
>> +	}
>> +
>>  	return result;
>>  }
> =

> =

> This routine causes a warning from gcc and looks indeed wrong: if the
> "vec" variable is used as an output variable of the inline assembly, it
> should be in the output section of the inline assembly, not the input
> section.
> =


Yes, seems wrong. Will try to look into it the next days.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130416/fdb62eb=
0/attachment.pgp>
