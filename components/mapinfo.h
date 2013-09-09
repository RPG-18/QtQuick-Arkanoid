#ifndef MAPINFO_H
#define MAPINFO_H

#include <vector>

#include <QtQuick/QQuickItem>

class MapInfo : public QQuickItem
{
    Q_OBJECT

    /*! путь к карте */
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)

    /*! число строк */
    Q_PROPERTY(int rows READ rows NOTIFY rowsChanged)

    /*! число столбцов */
    Q_PROPERTY(int columns READ columns NOTIFY columnsChanged)

public:
    explicit MapInfo(QQuickItem *parent = 0);

    QString source ()const;
    void setSource (const QString& source);

    int rows ()const;
    int columns ()const;

    /*!
      \brief получиение значения ячейки
     */
    Q_INVOKABLE int get(int row, int col) const;

signals:

    void sourceChanged ();
    void rowsChanged ();
    void columnsChanged ();

public slots:

private:

    /*!
      \brief загрузка карты
     */
    void loadMap ();

    QString m_source; //!< путь к карте
    int m_rows; //!< число строк
    int m_columns; //!< число столбцов
    std::vector<std::vector<quint8>> m_map;//!< матрица m_rows x m_columns

};

#endif // MAPINFO_H
