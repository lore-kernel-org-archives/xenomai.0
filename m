Subject: Re: Deadlock during debugging
References: <VI1PR05MB5917D854245374A7BF4E34BFF64D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e16b6953-47d4-4a80-ed21-d138be84cac4@xenomai.org>
Date: Tue, 19 Nov 2019 17:46:34 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917D854245374A7BF4E34BFF64D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 11/18/19 4:13 PM, Lange Norbert via Xenomai wrote:
> Hello,
> 
> Here's one of my deadlocks, the output seems interleaved from 2 concurrent dumps,
> I ran the crashlog through decode_stacktrace.sh.
> 

Ok, I can reproduce this one, including in a vm. The symptom can be either a lockup, or recursive faults. I'm on it.

-- 
Philippe.

