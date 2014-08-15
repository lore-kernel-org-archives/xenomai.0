Message-ID: <53EE2A85.4090904@xenomai.org>
Date: Fri, 15 Aug 2014 17:43:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEGbdidABiixUba3TiheYcLx1Swh5TrTbt_FtenZsExq7weUYg@mail.gmail.com>
 <53E93A3D.2060403@nta-inc.net> <53ED39DC.5030504@xenomai.org>
 <53EDCCFE.5030900@xenomai.org>
In-Reply-To: <53EDCCFE.5030900@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] C++ std::thread and xenomai pthread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Jorge Ramirez Ortiz <jro@xenomai.org>, xenomai@xenomai.org

On 08/15/2014 11:03 AM, Philippe Gerum wrote:
> On 08/15/2014 12:36 AM, Jorge Ramirez Ortiz wrote:
>> On 08/11/2014 05:48 PM, Jeff Webb wrote:
>>> On 08/11/2014 10:33 AM, Matthew Lindner wrote:
>>>> Has anyone experimented with using std::thread from the C++ STL library? I
>>>> am curious if it automatically incorporates the xenomai pthread API layer
>>>> or whether it bypasses that and accesses the linux pthread library.
>>
>>> Yes, I've tried this and it has worked for me.
>>
>> some years ago I presented this at XUM 2009.
>> Some of the recommendations are no longer valid - user space drivers for instance
>> (this project was before RTDM) - but we did use Xenomai to successfully deploy a
>> large scale C++ software project.
>> http://www.denx.de/en/pub/News/Xum2009AbstractsAndPresentations/Xenomai_and_Realtime_Image_Processing_Control.pdf
>>
> 
> Thanks for reminding me, I have referenced this material from our
> website at http://xenomai.org/start-here/#Other_readings.

Maybe it would make sense to link to:
http://www.denx.de/en/News/XenomaiUserMeeting2009
or
http://www.denx.de/en/News/Xum2009AbstractsAndPresentations

So that people have easy access to all the presentations.

-- 
                                                                Gilles.

