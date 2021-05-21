Subject: Re: Can dovetail in kernel 5.4 support both evl and xenomai 3.x ?
References: <20210521154642.36c9eb19@jamie-ThinkPad>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b301a055-0289-317c-425c-a47484acfd52@siemens.com>
Date: Fri, 21 May 2021 10:36:52 +0200
MIME-Version: 1.0
In-Reply-To: <20210521154642.36c9eb19@jamie-ThinkPad>
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
To: Jamie Huang <jamienstar@163.com>, xenomai@xenomai.org, rpm@xenomai.org

On 21.05.21 09:46, Jamie Huang via Xenomai wrote:
> Hi ALL:
> 	We know there are both ipipe and dovetail in kernel 5.4, and we
> will use kernel 5.4 for a longer period of time. We hope the dovetail
> of kernel 5.4 can support both evl and xenomai 3.x, like kernel 5.10.
> We are going to do the back porting. Any suggestions? Thanks
> 

For Xenomai 3.2, the first version to support dovetail, we do not plan
to support 5.4 over dovetail, only I-pipe. We need to keep an eye on the
test matrix. Anyone contributing help to this may change the picture,
though.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

