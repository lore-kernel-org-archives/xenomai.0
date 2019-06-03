Subject: Re: RTnet bind failed socket again
References: <ea8b5153-3530-4b7b-3a73-586cda346cbe@compador.de>
 <1523560934.2012965.1559553044281.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ebc7a250-dbaa-c898-f04c-2822199d2f3a@siemens.com>
Date: Mon, 3 Jun 2019 17:33:54 +0200
MIME-Version: 1.0
In-Reply-To: <1523560934.2012965.1559553044281.JavaMail.zimbra@wolfram.com>
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
To: Per Oberg <pero@wolfram.com>, Johannes Holtz <johannes.holtz@compador.de>
Cc: xenomai <xenomai@xenomai.org>

On 03.06.19 11:10, Per Oberg via Xenomai wrote:
> 
> 
> 
> ----- Den 3 jun 2019, på kl 11:06, xenomai xenomai@xenomai.org skrev:
> 
>> Hi,
> 
>> My program opens a RTnet socket successfully but the program gets killed
>> by a different issue that has nothing to do with this. However, the
>> RTnet socket is still bound. If I try to start the program again i get
>> the error "Address already in use". If it would be a normal unix socket
>> I would simply call it with SO_REUSEADDR but this is not possible with
>> RTnet from what I understand.
> 
> I tried this and failed miserably. That said, I'm also interested in the answer to this question.
> 
>> My question is why the socket is not unbound after the binding process
>> is killed and if there is a way to reclaim this socket. By the way, it
>> has to be this socket since the communication partner expects the server
>> to listen on this exact port.
> 
>> Cheers,
> 
>> Johannes
> 
> Per Öberg
> 

Are we talking about UDP in both cases?

What should happen: When a process dies, its open rt fds gets closed. RTDM will 
call down to the driver to do the necessary work, in case of UDP to rt_udp_close 
which also removes the entries from the port registry and bitmap. You can 
confirm that by tracing that part - or send a simple test case that reproduces 
the issue.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

