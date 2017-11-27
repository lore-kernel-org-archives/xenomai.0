References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <f7ad8163bda5484292ccdf6e8cf1a484@P10-EX02.3DSystems.Internal>
 <02f0df6b-0854-eeaa-a168-ae2c10e1d8ab@xenomai.org>
 <845269a3-e580-c8ff-e25d-a56d00c787fe@siemens.com>
 <2f850a60-3756-f06d-82c6-ccf6eeb58aa3@xenomai.org>
 <20171127204105.07C3512023A@gemini.denx.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <34fe6fb9-1a55-e432-3ef3-e16655abc59b@xenomai.org>
Date: Mon, 27 Nov 2017 22:44:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171127204105.07C3512023A@gemini.denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Service hosting for Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Denk <wd@denx.de>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Hello Wolfgang,

On 11/27/2017 09:41 PM, Wolfgang Denk wrote:
> Dear Philippe,
> 
> In message <2f850a60-3756-f06d-82c6-ccf6eeb58aa3@xenomai.org> you wrote:
>>
>> As Jan mentioned, there is more than having GIT underneath, there are
>> deep implications on the workflow, and it really depends on what we'd
>> want from such platform. If you have any thought, recommendation,
>> experience with those platforms in your daily work, it would be great to
>> know your views.
> 
> Full agreement.
> 
> What I can offer here an now is this:
> 
> 1) DENX can run the Xenomai mailing list.
> 
>    We already run some other lists, the U-Boot mailing list with
>    currently 2877 members being the most important. Adding another
>    list is just a few clicks aways.
> 
>    [OK, it takes abit more work to transfer the old mail archives,
>    but all this is pretty much straightforward.]
> 
> 2) DENX can host one ore more repositories for Xenomai on our gitlab
>    server (gitlab.denx.de).  We're planning for an upgrade anyway,
>    and compared to other stuff we have there Xenomay is just a tiny
>    addition.
> 
> Both services can be provided immediately.
> 
> 

Thank you for your kind proposal. Looking at the related discussion
earlier on this list, it seems that there is a consensus about gitlab
being one of the few appropriate options for the project, provided we
prevent cross-talk between the issue tracker and the mailing list,
choosing the latter exclusively.

I believe that such solution would be in the best interest of the user
base, providing for issue tracking and CI in the same move. Since Gitlab
also provides an integrated wiki, we could use it to publish the
existing documentation currently on http://xenomai.org which is entirely
composed of static contents.

This would not preclude from using additional services in the future
(IRC etc) hosted elsewhere, but having the core infrastructure at a
trusted place like Denx is the right move.

I'll get in touch with your team for carrying out this migration
gradually from my server to denx.de.

Thanks again.

-- 
Philippe.

