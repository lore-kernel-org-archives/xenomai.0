Subject: Re: About mayday question
References: <20181205152900.28540-1-rpm@xenomai.org>
 <1fc1841a-699f-1482-a411-911f95c85c25@siemens.com>
 <cd9a5aa5-190a-fac8-85f1-61acef83ab3e@linx-info.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a3041f06-574d-322e-d2a3-89bf486b4d4c@siemens.com>
Date: Mon, 10 Dec 2018 10:54:40 +0100
MIME-Version: 1.0
In-Reply-To: <cd9a5aa5-190a-fac8-85f1-61acef83ab3e@linx-info.com>
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
To: duanwujie <wjduan@linx-info.com>, xenomai@xenomai.org

On 10.12.18 10:51, duanwujie wrote:
> /Hi Philippe and Jan, I want to test //mayday mechanism,but we can't find any smoke test case about it.where can i 
> find it? /
> 

The sigdebug test in smokey stresses that path. It makes the watchdog fire by 
running an RT thread in a userspace-only loop.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

