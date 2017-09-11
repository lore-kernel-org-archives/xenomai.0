MIME-Version: 1.0
In-Reply-To: <CAMJ=MEe2+CS0nbjz+nQsFn4TDbKYjP7OQBBmOnbLtksjS-NDDA@mail.gmail.com>
References: <CAMJ=MEe2+CS0nbjz+nQsFn4TDbKYjP7OQBBmOnbLtksjS-NDDA@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Mon, 11 Sep 2017 08:43:36 +0200
Message-ID: <CAMJ=MEca95rQbVJhT8XBeVAAU4pN7Eh=vsNQoLNtXk+GzcyKGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Port of ThreadX to Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Thu, Sep 7, 2017 at 12:24 PM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
> Hello
>
> has threadX ever been considered as a candidate to be simulated by Xenomai?
> Or does somebody already have a private implementation available that
> has good enough quality to be upstreamed?
>
> Any information related to this is much appreciated.

I have been working on a prototype last Friday and there seems to be a rather
straight-forward mapping possible between the ThreadX API and the Alchemy
interface provided by Xenomai. I used the Mercury core for my testing.

For some functionality, like task creation, adaptations are needed but for most
functionality only error interface translation, like parameters and
error codes, is
needed.

If we would continue with this, I wonder what would be the best approach either
we build a layer on top of the Alchemy layer or we create a kind of
copy of the Alchemy
layer and do the needed adaptations there.
So this would mean that we have a ThreadX skin next to the pSOS and
VxWorks skins
in Xenomai, while the first solution would be outside Xenomai I assume.

Feedback is welcome.

For the people that do not know ThreadX, a full interface description
can be found here:
http://rtos.com/images/uploads/ThreadX_User_Guide_V5.pdf

Best regards
Ronny

