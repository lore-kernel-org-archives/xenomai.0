Subject: Re: Periodic timing varies across boots
References: <CA+K1mPFRVPqD_Gg2_7_PqcpegJ+ADJm3hea2AHxiHzwwBBG_iw@mail.gmail.com>
 <3d5044db-0b5c-fe4a-480c-b50943d440e5@siemens.com>
 <CA+K1mPEfLdrvGOqnX+1F6omFQq-CT75v2-5qTXF8Rj8NY=mHrQ@mail.gmail.com>
 <e557148a-392d-3c8e-615e-58c60c03e6e1@xenomai.org>
 <CA+K1mPENXX69Y+fF39dDXR1+pikeakcqKYkVfow-mD-QJcDJmw@mail.gmail.com>
 <056086d0-c53a-4494-7db5-224dcc325071@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <dee298b4-cd02-6cf5-0776-c8a92b80b2e5@xenomai.org>
Date: Fri, 1 Mar 2019 09:09:57 +0100
MIME-Version: 1.0
In-Reply-To: <056086d0-c53a-4494-7db5-224dcc325071@xenomai.org>
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
To: C Smith <csmithquestions@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 3/1/19 9:05 AM, Philippe Gerum via Xenomai wrote:
In order to mitigate this issue, you could try to isolate the
> CPU used by the rt work loop using isolcpus, even if this can't block
> any non-rt activity on that CPU, 
should read as: even if this can't fully block all non-rt activity on
this CPU.

-- 
Philippe.

