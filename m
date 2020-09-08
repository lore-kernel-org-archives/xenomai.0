References: <MN2PR12MB3757ADD03900875A8860682FF2290@MN2PR12MB3757.namprd12.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Assigning Interrupt Handlers
In-reply-to: <MN2PR12MB3757ADD03900875A8860682FF2290@MN2PR12MB3757.namprd12.prod.outlook.com>
Date: Tue, 08 Sep 2020 18:27:11 +0200
Message-ID: <87363s9qu8.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Frey, Fred (ext ???)" <f.frey@qvii.com>
Cc: "g.moro@qmul.ac.uk" <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Frey, Fred (ext ???) <f.frey@qvii.com> writes:

> Thank you both for your quick responses. I found both examples provided quite edifying.
>
> Philippe,
>
> Because of the simplicity of the driver I need to write, it sounds like you're recommending UDD over RTDM. Is that accurate?
>

If you can deal with the lack of detailed documentation, UDD has the
advantage of implementing pretty much what you described
already. Conversely, writing your own driver may help if you need it to
handle specific aspects of the PRU which could not be easily done based
on the generic UDD mechanisms. YMMV.

-- 
Philippe.

