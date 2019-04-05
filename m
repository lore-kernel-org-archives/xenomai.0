Subject: Re: EMSGSIZE whith send on RTcan socket
References: <057b4634-3127-3872-922d-f690c04c4bed@compador.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6c7f9009-21d0-a1ac-b73a-cfcd490b24df@siemens.com>
Date: Fri, 5 Apr 2019 12:19:14 +0200
MIME-Version: 1.0
In-Reply-To: <057b4634-3127-3872-922d-f690c04c4bed@compador.de>
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
To: Johannes Holtz <johannes.holtz@compador.de>, xenomai@xenomai.org

On 05.04.19 11:31, Johannes Holtz via Xenomai wrote:
> Hi,
> 
> While sending a multitude of SDOs via RTcan I get some EMSGSIZE errors. There is
> no obvious pattern to the occurrences and most of the messages are sent OK. I
> checked the parameters that I use and each frame is send with the same size (
> sizeof(can_frame_t) ) and each frame has a dlc of 8.
> 
> So my question is in which specific situation is the EMSGSIZE issued. The man
> page entry wasn't very helpful.
> 

Use the source:

https://gitlab.denx.de/search?utf8=%E2%9C%93&search=EMSGSIZE&group_id=&project_id=325&search_code=true&repository_ref=master

So

    /* Check msg_iovlen, only one buffer allowed */
    if (msg->msg_iovlen != 1)
        return -EMSGSIZE;

and

    /* Check size of buffer */
    if (iov->iov_len != sizeof(can_frame_t))
        return -EMSGSIZE;

But I think that is even in line with the documentation.

Maybe double-check in your applications after EMSGSIZE if any of those
conditions are violated?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

