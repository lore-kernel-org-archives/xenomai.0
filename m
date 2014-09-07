Message-ID: <540C8B61.4070906@gatech.edu>
Date: Sun, 07 Sep 2014 12:44:17 -0400
From: "Yogi A. Patel" <yapatel@gatech.edu>
MIME-Version: 1.0
References: <540C85F1.4070809@gatech.edu> <540C89BC.9030508@xenomai.org>
 <540C8A35.8090804@gatech.edu> <540C8ABC.8070200@xenomai.org>
In-Reply-To: <540C8ABC.8070200@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mlockall and dlopenskins?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 09/07/2014 12:41 PM, Gilles Chanteperdrix wrote:
> On 09/07/2014 06:39 PM, Yogi A. Patel wrote:
>> On 09/07/2014 12:37 PM, Gilles Chanteperdrix wrote:
>>> On 09/07/2014 06:21 PM, Yogi A. Patel wrote:
>>> The section named: MLOCKALL AND STACK SIZE says: As part of its
>>> initialization, Xenomai libraries call mlockall to commit and lock the
>>> whole application memory. How can that be made more clear?
>> It might be clearer if that statement was in or referenced to by the
>> section titled "BEFORE VERSION 2.6.3".
>>
>> What about the --enable-dlopen-skins warning? Are all skins compiled by
>> default now? I'm not experiencing any problems so far, but I would
>> rather understand what's going on than accept it blindly.
> --enable-dlopen-skins was a bad workaround for a stupid problem which
> has been fixed in 2.6.3.
So all skins are compiled by default, is that correct?

