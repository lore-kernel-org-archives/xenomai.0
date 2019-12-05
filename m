Subject: Re: undefined reference to `rt_task_create
References: <d3c4d944-807a-a2d4-7ec1-2d1639f36f78@vbm-grp.com>
 <48de04a3-9f2c-d3e6-8a80-568a497015c1@vbm-grp.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5cf98ffb-d244-1030-552e-a1ebed830df0@siemens.com>
Date: Thu, 5 Dec 2019 08:44:52 +0100
MIME-Version: 1.0
In-Reply-To: <48de04a3-9f2c-d3e6-8a80-568a497015c1@vbm-grp.com>
Content-Type: text/plain; charset=iso-8859-15
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
To: "Electronic Dept. - Vbm Group" <electronic@vbm-grp.com>, xenomai@xenomai.org

On 05.12.19 08:35, Electronic Dept. - Vbm Group via Xenomai wrote:
> Hello Jan,
> 
> thank you for your answer.
> 
> My Xenomai version is:
> 
> Xenomai/cobalt v3.0.9 -- #5b99a61 (2019-11-04 19:44:03 +0100)

OK, but when I call "xeno-config --skin=alchemy --ldflags" for that
version, I do have "-lalchemy" in the output. That would fix your
linking issue. Can you check the output you get?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

