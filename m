Message-ID: <2ff1a98a0805150228l7d99b025rae68cec2c02e4246@domain.hid>
Date: Thu, 15 May 2008 11:28:00 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <7df088046ee0bd577cb7040650d79a05@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18475.12268.192581.316526@domain.hid>
	<7df088046ee0bd577cb7040650d79a05@domain.hid>
Subject: Re: [Xenomai-help] VxWorks skin problem concerning WIND_TCBstructure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

On Thu, May 15, 2008 at 8:10 AM, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
> On Wed, 14 May 2008 20:31:08 +0200, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Matthie wrote:
>>> I still don't have any solution to emulate the fields above listed as I
>>> don't know if I can use Linux posix services ?
>>
>> Yes, you can use Linux posix services, but they will cause any Xenomai
>> thread to switch from primary mode to secondary mode.
>>
>> If you do not understand what I am talking about, you should probably
>> read the articles at:
>> http://www.xenomai.org/index.php/Publications
>>
>> --
>>
>>
>>                                           Gilles.
>
> That's the point. Using posix services is pretty much easy, but if this
> switches the thread to secondary mode, I'm not sure about using it.

I can not imagine code using WIND_TCB members for something else than debug.

 I think
> that VxWorks Task Control Block ,implemeted by  WIND RIVER, is keeping the
> context in hard real-time. That's why I would like to know if there are
> other possibilities ?

Yes, there are possibilities: fix your code not to use such internal
data as the WIND_TCB members.

-- 
 Gilles

