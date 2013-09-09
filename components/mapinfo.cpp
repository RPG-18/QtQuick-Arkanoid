#include <iostream>

#include <QtCore/QDir>
#include <QtCore/QFile>
#include <QtCore/QDebug>

#include "mapinfo.h"

MapInfo::MapInfo(QQuickItem *parent) :
    QQuickItem (parent),
    m_rows (0),
    m_columns (0)
{
}

QString MapInfo::source ()const
{
    return m_source;
}

void MapInfo::setSource (const QString& source)
{
    m_source = source;
    emit sourceChanged ();
    loadMap();
}

int MapInfo::rows ()const
{
    return m_rows;
}

int MapInfo::columns ()const
{
    return m_columns;
}
int  MapInfo::get(int row, int col) const
{
    try
    {
        return m_map.at(row).at(col);

    }catch(...)
    {
        return 0;
    }
}

void MapInfo::loadMap()
{
    QFile file(m_source);
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qWarning()<<"Invalid load map "<<m_source;
        return;
    }
    m_map.clear();
    quint8 chNull = '0';
    while(!file.atEnd())
    {
        const QByteArray row = file.readLine();
        std::vector<quint8> newRow (row.data(), row.data()+row.size()-1);

        for(size_t i = 0; i<newRow.size(); ++i)
        {
            newRow[i]-=chNull;
        }
        m_map.push_back(newRow);
    }

    m_rows = m_map.size();
    if(!m_map.empty())
    {
        m_columns = m_map[0].size();
    }

    emit columnsChanged ();
    emit rowsChanged ();
}
