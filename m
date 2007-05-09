Message-ID: <b647ffbd0705090442m65f213e9j3efbd86ba556cec8@domain.hid>
Date: Wed, 9 May 2007 13:42:31 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <22908039.1178707932628.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <22908039.1178707932628.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized for
	user space only applications
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 09/05/07, M. Koehrer <mathias_koehrer@domain.hid> wrote:
> [...]
>
> Thus my question/proposal is if there is a plan to use a "variant" of the native API that is optimized for
> user space only applications. In this case e.g. futexes can be used. If there is a need to
> reschedule to another task it is fine to "invest" the 2us but it can be avoided mostly which should
> increase the overall performance dramatically.

If it's always granted user-space tasks enter these lock/unlock calls
_only_ from the primary domain, it should be easy to implement (+ a
variant of atomic compare_and_swap operation for a given arch is
available). e.g. look at how linuxthreads does it e.g. in uClibc.

Given an additional restriction above (also quite bearable for some
apps. I guess) it likely would lead to introducing a separate type of
lock (maybe a sub-type of the existing).. not sure, consider it only
as brief comments at the moment.


-- 
Best regards,
Dmitry Adamushko

