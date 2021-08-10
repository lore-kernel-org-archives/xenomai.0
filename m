Subject: Re: [PATCH v5 0/5] y2038: Add mutex_timedlock64() support
References: <20210810102344.49471-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <262f8a56-2afb-b486-dcf5-a5032e137f7d@siemens.com>
Date: Tue, 10 Aug 2021 12:33:02 +0200
MIME-Version: 1.0
In-Reply-To: <20210810102344.49471-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 10.08.21 12:23, Florian Bezdeka wrote:
> Hi!
> 
> This series is based on the series posted by Song some time ago. The
> testing part has been heavily reworked. Details are mentioned in the 
> description of the last patch.
> 
> @Jan: Patch 1 and 2 are re-sends. They are not directly related to the 
> y2038 stuff but the testsuite might fail if they are not applied.
> 
> Testing was done on x86 only so far, internal CI is still running but no
> problems expected.
> 
> Best regards,   
> Florian
> 
> Changes in v5:
>   - Patch 5: Integrated fixes already made by Jan on next 
>   - Patch 5: Fix typo
> 

Is this series equivalent with bb64c8c66aeec3b5ead55fcfa9c79efda8064f7f
in next? Or do I have to replace next with it? Or do I only have to
replace bb64c8c66a (patch 5)?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

