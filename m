References: <CAMJ=MEe2+CS0nbjz+nQsFn4TDbKYjP7OQBBmOnbLtksjS-NDDA@mail.gmail.com>
 <CAMJ=MEca95rQbVJhT8XBeVAAU4pN7Eh=vsNQoLNtXk+GzcyKGA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fac80a33-6089-d3a7-e4c0-de131d661404@siemens.com>
Date: Mon, 11 Sep 2017 11:20:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEca95rQbVJhT8XBeVAAU4pN7Eh=vsNQoLNtXk+GzcyKGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Port of ThreadX to Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 2017-09-11 08:43, Ronny Meeus wrote:
> On Thu, Sep 7, 2017 at 12:24 PM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
>> Hello
>>
>> has threadX ever been considered as a candidate to be simulated by Xenomai?
>> Or does somebody already have a private implementation available that
>> has good enough quality to be upstreamed?
>>
>> Any information related to this is much appreciated.
> 
> I have been working on a prototype last Friday and there seems to be a rather
> straight-forward mapping possible between the ThreadX API and the Alchemy
> interface provided by Xenomai. I used the Mercury core for my testing.
> 
> For some functionality, like task creation, adaptations are needed but for most
> functionality only error interface translation, like parameters and
> error codes, is
> needed.
> 
> If we would continue with this, I wonder what would be the best approach either
> we build a layer on top of the Alchemy layer or we create a kind of
> copy of the Alchemy
> layer and do the needed adaptations there.
> So this would mean that we have a ThreadX skin next to the pSOS and
> VxWorks skins
> in Xenomai, while the first solution would be outside Xenomai I assume.
> 
> Feedback is welcome.
> 
> For the people that do not know ThreadX, a full interface description
> can be found here:
> http://rtos.com/images/uploads/ThreadX_User_Guide_V5.pdf
> 
> Best regards
> Ronny
> 

If you decide to build on top of Alchemy, I would recommend to document
non-obvious dependencies (those that do not use the external API of
Alchemy). Otherwise, you risk breakages when people change Alchemy for
whatever reason.

But code sharing is generally better than copying. Provided there is
enough to share.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

