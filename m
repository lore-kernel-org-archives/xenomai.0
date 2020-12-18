Subject: Re: [xenomai-images][PATCH 0/2] add xenomai 3.1.x to pipeline
References: <20201218094945.6941-1-Quirin.Gylstorff@siemens.com>
 <598760.1608297747@gemini.denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e6cb9740-b142-d84a-84b5-1098887c03cb@siemens.com>
Date: Fri, 18 Dec 2020 16:33:15 +0100
MIME-Version: 1.0
In-Reply-To: <598760.1608297747@gemini.denx.de>
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
To: Wolfgang Denk <wd@denx.de>, "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, "Q. Gylstorff via Xenomai" <xenomai@xenomai.org>

On 18.12.20 14:22, Wolfgang Denk wrote:
> Dear "Q. Gylstorff via Xenomai",
> 
> In message <20201218094945.6941-1-Quirin.Gylstorff@siemens.com> you wrote:
>>
>> Add xenomai 3.1 to the build and test pipeline of xenomai-images.
> 
> Is there a specific reason why all the new files come under a MIT
> license, and not GPL ?

Yes, these are bitbake recipes, derived from Isar recipes. We follow
that practice in all related projects.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

