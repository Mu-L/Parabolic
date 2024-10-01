#include "models/subtitlelanguage.h"
#include <format>
#include <libnick/helpers/stringhelpers.h>
#include <libnick/localization/gettext.h>

using namespace Nickvision::Helpers;

namespace Nickvision::TubeConverter::Shared::Models
{
    SubtitleLanguage::SubtitleLanguage(const std::string& language, bool isAutoGenerated)
        : m_language{ StringHelpers::lower(language) },
        m_isAutoGenerated{ isAutoGenerated }
    {

    }

    const std::string& SubtitleLanguage::getLanguage() const
    {
        return m_language;
    }

    bool SubtitleLanguage::isAutoGenerated() const
    {
        return m_isAutoGenerated;
    }

    std::string SubtitleLanguage::str() const
    {
        if(m_isAutoGenerated)
        {
            return std::format("{} ({})", m_language, _("Auto-generated"));
        }
        return m_language;
    }

    bool SubtitleLanguage::operator==(const SubtitleLanguage& other) const
    {
        return m_language == other.m_language && m_isAutoGenerated == other.m_isAutoGenerated;
    }

    bool SubtitleLanguage::operator!=(const SubtitleLanguage& other) const
    {
        return !operator==(other);
    }

    bool SubtitleLanguage::operator<(const SubtitleLanguage& other) const
    {
        if(m_isAutoGenerated && !other.m_isAutoGenerated)
        {
            return false;
        }
        else if(!m_isAutoGenerated && other.m_isAutoGenerated)
        {
            return true;
        }
        return m_language < other.m_language;
    }

    bool SubtitleLanguage::operator>(const SubtitleLanguage& other) const
    {
        if(m_isAutoGenerated && !other.m_isAutoGenerated)
        {
            return true;
        }
        else if(!m_isAutoGenerated && other.m_isAutoGenerated)
        {
            return false;
        }
        return m_language > other.m_language;
    }
}