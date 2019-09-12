Subject: Re: problem with RT/NTR for xenomai 3
References: <CA+CD0HS+U9w3tin=hg+MZhcMrdDQGvkSaBH39RyBD=CKb5q_eQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <047918e0-fb64-c8f3-66de-54a8dc92c342@siemens.com>
Date: Thu, 12 Sep 2019 12:17:29 +0200
MIME-Version: 1.0
In-Reply-To: <CA+CD0HS+U9w3tin=hg+MZhcMrdDQGvkSaBH39RyBD=CKb5q_eQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Yaofang WANG <yaofang.wang@smile.fr>, xenomai@xenomai.org

On 12.09.19 12:07, Yaofang WANG via Xenomai wrote:
> Hello all,
> 
> Currently, I am working in double scheduling. I have a problem with RT/NRT
> support in RTDM for Xenomai 3, my _nrt function is never called, but it
> works in Xenomai 2.6.
> 

If you would like to get support, you have to share more details. Can be code or 
sufficiently large code snippets.

Moreover, when porting to Xenomai 3, also make sure to study 
https://gitlab.denx.de/Xenomai/xenomai/wikis/Migrating_From_Xenomai_2_To_3 
carefully.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

