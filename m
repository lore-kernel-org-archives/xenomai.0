Subject: Re: [I-PIPE] ipipe-core-4.9.135-x86-7 released
References: <E1gHtmu-0002xR-FI@xenomai.org>
 <653100543.20966555.1541129646273@mail.yahoo.com>
 <009db19b-cb18-095c-2fda-eb9beaa7767c@siemens.com>
 <1378793b-2c18-1e51-937c-3ce14a7bb9e9@xenomai.org>
 <af13cc5e-a076-5618-e8f2-a62284a8493c@xenomai.org>
 <1782609254.2693150.1544069354612@mail.yahoo.com>
 <648d4857-fd53-7cbf-974f-e18ce5759f71@linx-info.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1139e58e-ca54-29cf-119a-3be099b9ff38@siemens.com>
Date: Thu, 6 Dec 2018 08:00:47 +0100
MIME-Version: 1.0
In-Reply-To: <648d4857-fd53-7cbf-974f-e18ce5759f71@linx-info.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: limingyu <myli@linx-info.com>, Alec Ari <neotheuser@ymail.com>
Cc: =?UTF-8?B?5b+X6IiqIOW9rQ==?= <zhpeng@linx-info.com>, =?UTF-8?B?5YiY5bKz5a6B?= <ynliu@linx-info.com>, xenomai@xenomai.org

On 06.12.18 06:45, limingyu via Xenomai wrote:
> I have used this patch(ipipe-core-4.9.135-x86-7.patch) for a test usage and I 
> got a machine halt after I run the latency test program of Xenomai.The problem 
> seems caused by  the fpu_restore function. Could you please fix it in the next 
> patch release?

Did you also update Xenomai to the latest stable or master branch state? That is 
required on x86.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

